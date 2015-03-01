require "csv"

class EntryCSVGenerator
  
  def self.generate(entries)
    new(entries).generate
  end

  def self.generate_user(entries)
    new(entries).generate_user
  end

  def initialize(entries)
    @report = Report.new(entries)
  end

  def generate
    CSV.generate do |csv|
      csv << @report.headers
      @report.each_row do |entry|
        csv << [
          entry.date,
          entry.user,
          entry.project,
          entry.code,
          entry.category,
          entry.client,
          entry.hours,
          entry.billable,
          entry.billed,
          entry.description
        ]
      end
    end
  end

  def generate_user
    CSV.generate do |csv|
      csv << @report.headers_user
      @report.each_row do |entry|
        csv << [
          entry.date,
          entry.project,
          entry.code,
          entry.hours
        ]
      end
    end
  end

  def self.generate_projects(entries)
    CSV.generate do |csv|
      csv << Report.headers_projects
      entries.each do |entry|
        csv << [
          entry[:project],
          entry[:code],
          entry[:hours]
        ]
      end
    end
  end
end
