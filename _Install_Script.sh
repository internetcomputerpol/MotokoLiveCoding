#!/bin/bash

TOTAL_STEPS=12
CURRENT_STEP=0

show_progress() {
    CURRENT_STEP=$((CURRENT_STEP + 1))
    local percent=$((CURRENT_STEP * 100 / TOTAL_STEPS))
    local completed=$((percent / 2))
    local remaining=$((50 - completed))
    
    echo -ne "\rInstallation progress: ["
    for ((i = 0; i < completed; i++)); do echo -n "#"; done
    for ((i = 0; i < remaining; i++)); do echo -n " "; done
    echo -ne "] ${percent}%"
    echo
}

execute_step() {
    echo -e "\n🔹 $1..."
    if eval "$2"; then
        echo "✅ Success: $1"
        show_progress
    else
        echo "❌ Error: $1"
        exit 1
    fi
}

echo "🔄 Starting development environment installation on Ubuntu..."

execute_step "Updating package list" "sudo apt update"
execute_step "Installing curl" "sudo apt install -y curl"

execute_step "Installing NVM (Node Version Manager)" "
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.4/install.sh | bash &&
    export NVM_DIR=\"\$HOME/.nvm\" &&
    [ -s \"\$NVM_DIR/nvm.sh\" ] && . \"\$NVM_DIR/nvm.sh\"
"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

if ! command -v nvm &> /dev/null; then
    echo "❌ Error: NVM was not installed correctly!"
    echo "Try running the following steps:"
    echo "1. source ~/.bashrc"
    echo "2. source \$HOME/.nvm/nvm.sh"
    exit 1
fi

execute_step "Installing Node.js (LTS)" "nvm install --lts && nvm use --lts"
execute_step "Checking Node.js version" "node -v"
execute_step "Updating npm" "npm install -g npm"

# Installing and initializing DFINITY SDK
execute_step "Installing DFINITY SDK (dfx)" "sh -ci \"\$(curl -fsSL https://internetcomputer.org/install.sh)\""

execute_step "Configuring PATH for dfx" "
    echo 'export PATH=\"\$PATH:\$HOME/.local/share/dfx/bin\"' >> \$HOME/.bashrc &&
    echo 'source \"\$HOME/.local/share/dfx/env\"' >> \$HOME/.bashrc &&
    export PATH=\"\$PATH:\$HOME/.local/share/dfx/bin\" &&
    source \"\$HOME/.local/share/dfx/env\"
"

if ! command -v dfx &> /dev/null; then
    echo "❌ Error: dfx was not installed correctly!"
    echo "Try running the following steps:"
    echo "1. export PATH=\"\$PATH:\$HOME/.local/share/dfx/bin\""
    echo "2. source \$HOME/.local/share/dfx/env"
    echo "3. source ~/.bashrc"
    exit 1
fi

execute_step "Adding Microsoft repository" "
    sudo apt-get install -y wget gpg &&
    wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg &&
    sudo install -D -o root -g root -m 644 packages.microsoft.gpg /usr/share/keyrings/packages.microsoft.gpg &&
    sudo sh -c 'echo \"deb [arch=amd64,arm64,armhf signed-by=/usr/share/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main\" > /etc/apt/sources.list.d/vscode.list' &&
    rm -f packages.microsoft.gpg
"

execute_step "Updating package list after adding repository" "sudo apt update"
execute_step "Installing Visual Studio Code" "sudo apt install -y code"

execute_step "Activating environment" "source ~/.bashrc"

echo -e "\n✅ Installation completed successfully!"
echo "Installed:"
echo "  - curl"
echo "  - NVM + Node.js (LTS)"
echo "  - npm"
echo "  - DFINITY SDK (dfx)"
echo "  - Visual Studio Code"
echo -e "\nDevelopment environment tailored for ICP. Happy coding 😊"
