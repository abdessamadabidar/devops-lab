# Log Archive Tool

This project is a **Log Archive Tool** based on the [DevOps Roadmap log-archive project](https://roadmap.sh/projects/log-archive-tool).  
It provides a script to collect and display key server metrics, making it easier to monitor server health during DevOps operations.

## Getting Started

### Clone the Repository
```
$ git clone git@github.com:abdessamadabidar/devops-lab.git

$ cd devops-lab/log-archive
```

### Ensure Script Permissions
```
$ chmod +x log-archive.sh
```

### Run the Script

Before running the script, add some log subdirectories to the **logs** directory to verify that the script works.
```
$ ./log-archive.sh 'logs'
```

After running the script, the compressed log directories will be placed in the **archives** directory.

