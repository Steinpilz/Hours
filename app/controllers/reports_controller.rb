require 'rubygems'
require 'zip'

class ReportsController < ApplicationController
  include CSVDownload

  def index
    @filters = EntryFilter.new(params[:entry_filter])
    @entries = entries

    respond_to do |format|
      format.html
      format.csv { send_csv(name: current_subdomain, entries: @entries) }
    end
  end

  def download_all_files
    @entries = entries

    t = Tempfile.new("my-temp-filename-#{Time.now}")
    Zip::OutputStream.open(t.path) do |z|
      users = User.all
      users.each do |user|
        items = entries.where(user_id:user.id)
        z.put_next_entry("#{user.full_name}_#{Time.now.strftime('%m.%Y')}.csv")
        z.print EntryCSVGenerator.generate_user(items)
      end


      projects = entries.joins(:project).select("projects.name as project, projects.code, sum(entries.hours) as hours").group("projects.name", "projects.code")

      z.put_next_entry("projects_#{Time.now.strftime('%m.%Y')}.csv")
      z.print EntryCSVGenerator.generate_projects(projects)
    end
 
    send_file t.path, :type => 'application/zip',
                                 :disposition => 'attachment',
                                 :filename => "Reports.zip"
                                 
    t.close
  end

  private

  def entries
    entries = EntryQuery.new(policy_scope(Entry), params[:entry_filter]).filter
    if params[:format] == "csv"
      entries
    else
      entries.page(params[:page]).per(20)
    end
  end
end
