# SSH Key
- SSH keys provide a secure way of logging into a virtual machine without the need for a password. When creating a new virtual machine on Azure, you can authenticate using SSH keys rather than a password.

## Steps to Create an SSH Key Pair (Using Linux/macOS or Windows PowerShell)

Open a Terminal or PowerShell:


- **ls -a** (display all the hidden file - files starting with a dot .)
- **pwd**
- **mkdir .ssh** (directory)
- **cd .ssh**
- **ls**
- **ssh-keygen -t rsa -b 4096 -C "email@yahoo.com"** 
    - -t rsa - specifies the type of key to create (RSA)
    - -b 4096 - sets the legth of the key 4096 bits
    - -C "email@yahoo.com" - add a label to the key for identification
- **ask for the key name** : enter key name
- **enter a passphrase** : press enter
- **ls**
- **cat the key.pub**
- **copy the ssh key and in the azure window**:
    - in the SSH key add new key by clicking create , set the key pai name to be the same like the name u gave to the key - then upload existing public key and paste ur public