# Slack Wifi Status

Set your Slack status to either :house_with_garden: or :coffee: based on your wifi SSID.

You list a set of SSIDs that count as being at home. If you're at home, then your status is set to

> :house_with_garden: At Home

If you are using an SSID not on the list, then your status is set to

> :coffee: At a coffee shop

## Setup

### Retrieve Slack API token
- Navigate to https://api.slack.com/custom-integrations/legacy-tokens
- Press the "create token" button for Team iCapps
- Confirm with your password
- The token should be available now. Copy for later ue

### Setup script
- Clone the Ruby scripts from this repo. 
- Save it for example in your `~/Applications` folder.
- Navigate to the `~/Applications/slack-wifi-status/config/slack.yml` file.

- You'll see the config like below:

```
oauth_key: "your-slack-oauth-key"
ssids:
  - "iCapps,@icapps,:icapps:"
  - "iCapps Corda,@Corda,:corda:"
  - "Farmboy Co-working,@icapps Gent,:gent:"
  - "iCapps Mechelen,@icapps Mechelen ,:mechelen:"
  - "CRONOS Guest,@Cronos,:cronos:"
  - "Your home ssid,@home,:house_with_garden:"
unknown:
  - "Working in an unknown environment,:zap:"
```

- Fill in the API token that you generated in the first step.
- The 'ssids' section is a list of all SSID names, linked with a description and emoji; you can add as many items as you want (wink).
- Save your changes and close the file.

### Schedule the script

- Open terminal
- Type the following: `crontab -e`
- Type the following: `i`
- Paste the following: (if you didn't unzip into the Applications folder, make sure the path below is correct)
`*/5 * * * * cd ~/Applications/slack-wifi-status && ./bin/update-slack-status > /dev/null 2> /dev/null`
=> this will schedule the script to run every 5 minutes (change de '5' at the start of the line if you want to run the script less frequent)
- Press the `esc` button
- Type the following: `:wq`

It's done! The script should run automatically. You can confirm this by opening terminal and typing `crontab -l`

If you received an error "bad day of week" when saving the crontab, please try the following:

`0,5,10,15,20,25,30,35,40,45,50,55 * * * * cd ~/Applications/slack-wifi-status && ./bin/update-slack-status > /dev/null 2> /dev/null`