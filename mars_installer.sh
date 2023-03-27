#!/bin/bash

# Check whether Homebrew is installed
if ! command -v brew &> /dev/null; then
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
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


# Create a MARS initializer file in /usr/local/bin. need sudo to write to /usr/local/bin
echo "Creating MARS initializer file..."
sudo touch /usr/local/bin/mars
if [ $? -ne 0 ]; then
  echo "Error: Failed to create MARS initializer file."
  exit 1
fi

# Write the MARS initializer file
echo "Writing MARS initializer file..."
sudo sh -c 'echo "#!/bin/bash" > /usr/local/bin/mars'
sudo sh -c 'echo "nohup java -jar /Applications/Mars.jar >/dev/null 2>&1 &" >> /usr/local/bin/mars'

# Make MARS executable
echo "Making MARS executable..."
sudo chmod +x /usr/local/bin/mars
if [ $? -ne 0 ]; then
  echo "Error: Failed to make MARS executable."
  exit 1
fi

echo "MARS simulator installed successfully."

echo 'open a new terminal and type "mars" to run MARS.'