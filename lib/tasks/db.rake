require "csv"
require "Date"

namespace :db do
  	desc "TODO"
  	task import_projects: :environment do
	  	if Hours.single_tenant_mode?
  			file_path = Rails.root.join('data/harvest_projects.csv')
  			csv_projects_read(file_path)
		else
		    puts "You're not in single tenant mode. If you want to use the single tenant mode set: 'SINGLE_TENANT_MODE=true' in your environment variables"
		end
  	end


	task import_hours: :environment do
  		if Hours.single_tenant_mode?
  			file_path =  Rails.root.join('data/harvest_time_report_from.csv')
  			csv_hours_read(file_path)
		else
		    puts "You're not in single tenant mode. If you want to use the single tenant mode set: 'SINGLE_TENANT_MODE=true' in your environment variables"
		end
  	end

  	def csv_projects_read(file_path)
	    CSV.foreach(file_path,headers: true, encoding: "UTF-16BE", col_sep: ';') do |row|
		    client_name =  row[0]
		    project_name = row[1]
		    project_code = row[2]
		    project_description = row[3]
		    project_budget = row[4]

		    cl = Client.where(name: client_name).first_or_create!
		   	
	 		pr = Project.where(name: project_name).first
		    unless pr
			    Project.create!(
			    	name: project_name,
			    	code: project_code,
			    	description: project_description,
			    	budget: project_budget,
			    	client_id: cl.id,
			    	billable: true )
			end
		end
    end

    def csv_hours_read(file_path)
	    CSV.foreach(file_path,headers: true, encoding: "UTF-16BE", col_sep: ';') do |row|
		    date =  row[0]
		    project_name = row[1]
		    note = row[2]
		    hours = row[3]
		    user_name = row[4]

		    us = User.where(first_name: user_name).first
		   	if us
		 		pr = Project.where(name: project_name).first
			   	if pr
					Entry.create!(
						project_id: pr.id,
						category_id: 1,
						user_id: us.id,
						hours: hours.gsub(",",".").to_f,
						date:  Date.strptime(date, '%d.%m.%y') )
				end
			end
		    
		end
    end
end
