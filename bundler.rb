#!/usr/bin/env ruby

require 'CSV'
require 'zip'
require 'yaml'
require 'fileutils'

file_map = YAML.load_file("files.yml")

# Create the bunles dir
dirname = 'bundles'
FileUtils.mkdir_p(dirname) unless File.directory?(dirname)

# Orders CSV to a hash
order_file = ARGV[0]
orders = CSV.new(File.open(order_file, "r"), :headers => true, :header_converters => :symbol)
orders = orders.to_a.map { |row| row.to_hash }

# Collect customer's skus in to hash
customer_orders = {}
orders.each do |order|
  purchaser = order[:billing_name]

  # If purchaser key exists, add sku
  if customer_orders.key?(purchaser)
    customer_orders[purchaser] << order[:sku] unless customer_orders.include?(order[:sku])
  else
    customer_orders[purchaser] = [order[:sku]]
  end
end

customer_orders.each do |purchaser, skus|
  # Strip non alphanumeric charaters, replace with '-'
  zip_name = purchaser.gsub(/[^a-zA-Z0-9\s]+/, "\s").squeeze.strip.gsub(/\s+/, '-') + '.zip'

  # Zip the files
  Zip::File.open('bundles/' + zip_name, Zip::File::CREATE) do |zip_file|
    skus.each do |sku|
      # Skip titles that have no associated files
      next if file_map[sku].nil?
      
      begin
        file_map[sku]["files"].each do |file|
          zip_file.add(file, 'files/' + file)
        end
      rescue Exception => e
        puts "#{purchaser}: #{e.message}"
      end
    end
  end
end