# README #

Bundler collects files associated with a product into a customer Zip file.

Huh?

Bundler looks through a CSV of customer orders and gathers all the items a customer has purchased. It then collects an associated list of files, based on an item's SKU, and puts them in to a custom Zip file for the customer.

Imagine a scenario.

Ballard School of Seafaring (BSS) sells training DVDs for the Maritime Industry. Companies rely on their videos to train their crew on topics such as "Oily Water Seperators," "Hand Safety," and "PPE."

All is good, customers are happy, and BSS keeps producing videos on more and more topics. But BSS soon realizes there's a critical piece that would compliment their videos. Assessments! An exam training managers can present their crew after they've watched a video. What better way for their customers to confirm topic comprehension!

BSS decides to write exam questions for each of their videos and send them to customers. But they have no way of easily collecting the exma and answer key files based on a customer's order history!

Enter Bundler. Now BSS can drop their assessment files into files\\, set up the file mappings (files.yml), and run the app. Done!

# Usage #

Bundler expects a couple things:

1. An orders CSV with a 'Billing name' and 'SKU' header.
2. File.yml with SKU to file name mappings.

Once that's in place, pass your CSV as a argument:

> ./bundler.rb orders.csv

You can then find the Zipped files in bundles\\