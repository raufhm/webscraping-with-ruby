

require 'nokogiri' # package manager or library build to parse HTML & XML in ruby
require 'httparty' # Ruby library that will output the response as a pretty-printed Ruby object
require 'byebug'   # ruby library to debug the source 

def scraper
	
	# website target we are going to scraping is Glints.com"

	url = "https://glints.com/id/opportunities/jobs/explore" 
	unparsed_page = HTTParty.get(url)                        
	parsed_page = Nokogiri::HTML(unparsed_page)
	jobs = Array.new

	# div tag below is referring to div class for every cards that store information that we need in this test 
	# job name & company name information that we will retrieve here.


	job_lists = parsed_page.css("div.CompactOpportunityCardsc__CompactJobCardInfo-sc-1xtox99-6.giRQjJ.job-card-info")
	job_lists.each do |job_list|
		job = {
			job_name: job_list.css("h3").text,
			company_name: job_list.css("a").text
		}

		jobs << job

	end
	# byebug

	# we will put all data that we scrpaing from target into text file.
	# Every time this script execute, it will refresh with the new one.

	File.delete("list_job.txt") if File.exist?("list_job.txt")
	File.open("list_job.txt", "w") do |f|
		
		f.puts "**********************************************************"
		f.puts "#{jobs.count} List jobs now available at Glints"
		f.puts "**********************************************************"
		f.puts ""

		counter = 0
		jobs.each do |d| 
			counter += 1
			f.puts "**********************************************************"
			f.puts "[#{counter}]" 
			f.puts "Job Name: #{d[:job_name]}"
			f.puts "Company : #{d[:company_name]}"
			f.puts "**********************************************************"

			end

			
			puts "Total Job: #{jobs.count} Jobs"
		end
	end


scraper
