# tf-toolsDeploy

This terraform script creates a droplet and installs bug bounties tools. Currently, following tools are installed:

+ amass
+ naabu
+ ffuf

You can add more tools by modifying ``core/digitalocean/scripts/deploy_tools.sh``.

### Disclaimer
Note that modifying the above script will destroy the current droplet and recreate the new one.

### Bash script output
To check output of the above bash script, check the following file in the droplet:
```
tail -100f /var/log/cloud-init-output.log
```

### Config
+ Copy ``config/sample_config.json`` as ``config/config.json``.
+ Update `do_token` in the ``config/config.json`` with `READ/WRITE` digitalocean token.