package main

import (
	"syscall"
	"time"
	"strings"
	"bytes"
	"os/exec"
	"encoding/json"
	"flag"
	"fmt"
	"io/ioutil"
	"log"
	"os"
	"regexp"
	"github.com/xlzd/gotp"
)

//Config type
type Config struct {
	UserName    string
	Password    string
	OTPPassword string
	Profile     string
}

func generateUserPassFile(config Config, execOptions map[string]bool) {
	filename := fmt.Sprintf("%s.pass", config.UserName)
	os.Remove(filename)
	var otpNow string
	if config.OTPPassword != "" {
	totp := gotp.NewDefaultTOTP(config.OTPPassword)
	otpNow = totp.Now()
	} else {
		otpNow = ""
	}
	content := fmt.Sprintf("%s\n%s%s", config.UserName, config.Password, otpNow)
	ioutil.WriteFile(filename, []byte(content), 0600)
	replacePtn := regexp.MustCompile(`(?m:^auth\-user\-pass.*$)`)
	profileContent, err := ioutil.ReadFile(config.Profile)
	if err != nil {
		log.Fatal("Can not read openvpn profile")
	}
	newContent := replacePtn.ReplaceAllLiteral(profileContent, []byte(fmt.Sprintf("auth-user-pass %s.pass", config.UserName)))
	removeTunOptPtn := regexp.MustCompile(`(?m:^persist-tun[\s]*$)`)
	newContent = removeTunOptPtn.ReplaceAllLiteral(newContent, []byte("#persist-tun"))

	ioutil.WriteFile(config.Profile, newContent, 0600)
}

func main() {
	configFilePath := flag.String("c", "", "Config file. A Json file with key: 'UserName', 'Password', 'OTPPassword', 'Profile'\nProfile is the profile filename")
	debug := flag.Bool("d", false, "Enable debug output")
	monitor := flag.Bool("m", false, "Monitor openvpn\nThis will restart openvpn if it exited. It also will remove the option persist-tun in the config to be sure a reconnection with full default route will be succeeded")
	execOpenvpn := flag.Bool("exec", false, "Use system execv to exec openvpn\nThis will keep the process open (not exiting) by exec the openvpn process. Good as docker entry point command")
	flag.Parse()

	configJSONData, err := ioutil.ReadFile(*configFilePath)
	if err != nil {
		log.Fatal("Can not read config")
	}
	config := Config{}
	stat, err := os.Stat(*configFilePath)
	if stat.Mode() != 0600 {
		log.Fatal("Config file mode should be 0600")
	}
	err = json.Unmarshal(configJSONData, &config)
	if err != nil {
		log.Fatal("Can not parse config. Is it json file?")
	}
	execOption := make(map[string]bool)
	execOption["monitor"] = *monitor
	execOption["execOpenvpn"] = *execOpenvpn
	for {
		generateUserPassFile(config, execOption)
		if *execOpenvpn {
			syscall.Exec("/usr/sbin/openvpn", []string{"/usr/sbin/openvpn", config.Profile}, []string{} )
		} else {
			cmd := exec.Command("openvpn", config.Profile)
			var out bytes.Buffer
			cmd.Stdout = &out
			err = cmd.Start()
			if err != nil {
				log.Fatal(err)
			}
			for count :=1; count * 3 < 120; count++ {
				time.Sleep(3 * time.Second)
				cmdOutput := out.String()
				if *debug {log.Printf("%s", cmdOutput)}
				if strings.Contains(cmdOutput, "process exiting") {
					log.Fatal("CRITICAL ERROR - openvpn output contains the error string")
				} else if strings.Contains(cmdOutput, "Initialization Sequence Completed") {
					log.Println("Got Initialization Sequence Completed")
					if *monitor {
						cmd.Wait()
						log.Println("Openvpn Process exited, restarting...")
						out.Reset()
						break //inner for
					} else {
						os.Exit(0)
					}
				}
			}
		}
	}
}
