#!/bin/bash

# Check whether Homebrew is installed
if ! command -v brew &> /dev/null; then
  echo "Installing Homebrew..."
  NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  if [ $? -ne 0 ]; then
    echo "Error: Failed to install Homebrew."
    exit 1
  fi
  else
    echo "Homebrew is already installed. Continuing..."
fi

# Update Homebrew recipes
echo "Updating Homebrew..."
brew update
if [ $? -ne 0 ]; then
  echo "Error: Failed to update Homebrew."
  exit 1
fi

# Install openjdk.
echo "Installing openjdk..."
brew install --quiet openjdk
if [ $? -ne 0 ]; then
  echo "Error: Failed to install openjdk."
  exit 1
fi

# if mars is not installed, install it. use brew list with grep to determine if mars is installed
echo "Installing MARS..."
brew install --quiet mars
if [ $? -ne 0 ]; then
  echo "Error: Failed to install MARS."
  exit 1
fi


# Create a MARS initializer file in /usr/local/bin
echo "Creating MARS initializer file..."
echo '#!/bin/bash' > sudo /usr/local/bin/mars
echo 'nohup java -jar /Applications/Mars.jar >/dev/null 2>&1 &' >> sudo /usr/local/bin/mars
if [ $? -ne 0 ]; then
  echo "Error: Failed to create MARS initializer file."
  exit 1
fi

# Make MARS executable
echo "Making MARS executable..."
sudo chmod +x /usr/local/bin/mars
if [ $? -ne 0 ]; then
  echo "Error: Failed to make MARS executable."
  exit 1
fi

echo "MARS simulator installed successfully."