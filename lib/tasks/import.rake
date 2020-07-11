require 'csv'

desc "Import CSV Data"
task import: :environment do

  total_customers = Customer.all.length
  Customer.destroy_all
  p "#{total_customers} customers destroyed."

  total_merchants = Merchant.all.length
  Merchant.destroy_all
  p "#{total_merchants} merchants destroyed."

  total_items = Item.all.length
  Item.destroy_all
  p "#{total_items} items destroyed."

  total_invoices = Invoice.all.length
  Invoice.destroy_all
  p "#{total_invoices} invoices destroyed."

  total_invoice_items = Merchant.all.length
  Merchant.destroy_all
  p "#{total_invoice_items} invoice items destroyed."

  total_transactions = Transaction.all.length
  Transaction.destroy_all
  p "#{total_transactions} transactions destroyed."

  customers = CSV.parse(File.open('/data/customers.csv'),
              headers: true,
              header_converters: :symbol )

  customers.each do |row|
    Customer.create({
      id:         row[0],
      first_name: row[1],
      last_name:  row[2],
      created_at: row[3],
      updated_at: row[4] })
  end

  p "#{Customer.all.length} customers created."


  merchants = CSV.parse(File.open('/data/merchants.csv'),
              headers: true,
              header_converters: :symbol )

  merchants.each do |row|
    Merchant.create({
      id:         row[0],
      name:       row[1],
      created_at: row[2],
      updated_at: row[3]  })
  end

  p "#{Merchant.all.length} merchants created."

  items = CSV.parse(File.open('/data/items.csv'),
              headers: true,
              header_converters: :symbol )

  items.each do |row|
    Item.create({
      id:          row[0],
      name:        row[1],
      description: row[2],
      unit_price:  row[3].to_f/100,
      merchant_id: row[4], 
      created_at:  row[5], 
      updated_at:  row[6] })    
  end

  p "#{Item.all.length} items created."

  invoices = CSV.parse(File.open('/data/invoices.csv'),
            headers: true,
            header_converters: :symbol )

  invoices.each do |row|
    Item.create({
      id:          row[0],
      customer_id: row[1],
      merchant_id: row[2],
      status:      row[3],
      created_at:  row[4], 
      updated_at:  row[5] })
  end

  p "#{Invoice.all.length} invoices created."

  invoice_items = CSV.parse(File.open('/data/invoice_items.csv'),
            headers: true,
            header_converters: :symbol )

  invoice_items.each do |row|
    InvoiceItem.create({
      id:         row[0],
      item_id:    row[1],
      invoice_id: row[2],
      quantity:   row[3],
      unit_price: row[4].to_f/100, 
      created_at: row[5], 
      updated_at: row[6] })    
  end

  p "#{InvoiceItem.all.length} invoice items created."

  transactions = CSV.parse(File.open('/data/transactions.csv'),
            headers: true,
            header_converters: :symbol )

  transactions.each do |row|
    Transaction.create({
      id:                          row[0],
      invoice_id:                  row[1],
      credit_card_number:          row[2],
      credit_card_expiration_date: row[3],
      result:                      row[4], 
      created_at:                  row[5], 
      updated_at:                  row[6] })    
  end

  p "#{Transaction.all.length} transactions created."

  ActiveRecord::Base.connection.tables.each do |table|
    ActiveRecord::Base.connection.reset_pk_sequence!(table)
  end

  p "Import complete."
end