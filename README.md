# Introduction

This project reads the stats from a Tesla Wall Connector and puts them into
an InfluxDB for historical purposes.  You can then use this information to 
build graphs or charts.  I suspected my Tesla Wall Connector was overheating
so I built this project and used Graphana to make it pretty.

# Requirements

* Ruby (some modern version)
* InfluxDB

# Installation

1. Install InfluxDB as outlined on their web site
2. Make sure you have a recent version of Ruby
3. Update the `main.rb` file and change the "HOSTS" parameters
4. Run the program `ruby main.rb`

# Optional

1. Install Graphana
2. Use InfluxDB as a source
3. Create pretty pictures of your Tesla Wall Connector stats
