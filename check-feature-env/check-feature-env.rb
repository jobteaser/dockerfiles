#!/usr/bin/env ruby

require 'optparse'
require 'octokit'

Options = Struct.new(:repo, :labels, :prs, :git_access_token, :removal_tip)

class Parser
  def self.parse(options)
    args = Options.new()

    opt_parser = OptionParser.new do |opts|
      opts.banner = "Usage: check_pr.rb [options]"

      opts.on("-r", "--repository REPOSITORY", "repository to be checked") do |r|
        args.repo = r
      end

      opts.on("-l", "--label label1,label2", Array, "label filtering list") do |l|
        args.labels = l
      end

      opts.on("-p", "--pr pr1,pr2", Array, "PR numbers with running feature-env") do |p|
        args.prs = p
      end

      opts.on("-t", "--removal-tip", "only display feature-env to remove as a list") do |t|
        args.removal_tip = t
      end

      opts.on("-h", "--help", "Prints this help") do
        puts opts
        exit
      end
    end

    opt_parser.parse!(options)

    raise OptionParser::MissingArgument('repo') if args[:repo].nil?

    return args
  end
end

def setup_octokit(options)
  Octokit.auto_paginate = true
  Octokit.configure do |c|
    c.access_token = options.git_access_token
  end
end

def main
  options = Parser.parse ARGV
  
  options.git_access_token = ENV.fetch("GIT_ACCESS_TOKEN")
  
  setup_octokit(options)
  prs = Octokit.pull_requests(options.repo, { state: 'open', sort: 'updated', direction: 'asc' })
  
  
  # filter by labels
  if not options.labels.nil?
    prs = prs.select do |pr|
      labels = pr[:labels] || []
      options.labels.all? do |label|
        labels.find{ |l| l['name'].to_s.casecmp(label.to_s.downcase).zero? }
      end
    end
  end
  
  # check current state agains wanted state
  prs_wanted = prs.map { |pr| pr.number.to_s }
  
  options.prs ||= []
  
  prs_running = options.prs
  prs_to_throw = prs_running.find_all { |pr| not prs_wanted.include?(pr) }
  prs_to_keep = prs_running.find_all { |pr| prs_wanted.include?(pr) }

  # display
  if options.removal_tip
    puts prs_to_throw.join(',')
  else
    puts "Feature-env's to be removed:"
    puts prs_to_throw
    
    # refilter against github list to keep 
    prs_to_keep_github = prs.find_all{ |pr| prs_to_keep.include?(pr.number.to_s) }
    puts "\nFeature-env's to keep: #{prs_to_keep_github.count}"
    prs_to_keep_github.each do |pr|
      puts "#{pr.number} (#{pr.updated_at.to_s})"
    end
  end
end

main
