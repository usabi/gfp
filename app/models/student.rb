class Student < ActiveRecord::Base
  attr_accessible :name
      
  def self.import(file)
    spreadsheet = open_spreadsheet(file)
    header = spreadsheet.row(1)
    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      student = find_by_id(row["id"]) || new
      student.attributes = row.to_hash.slice(*accessible_attributes)
      student.save!
    end
  end

  def self.open_spreadsheet(file)
    debugger
    case File.extname(file.original_filename)
    when ".csv" then CSV.read(file.path)
    when ".xls" then Excel.new(file.path, nil, :ignore)
    when ".xlsx" then Excelx.new(file.path, nil, :ignore)
    else raise "Unknown file type: #{file.original_filename}"
    end
  end
end
