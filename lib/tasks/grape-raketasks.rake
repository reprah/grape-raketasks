namespace :grape_raketasks do
  desc 'Print routes provided by Grape APIs to the terminal. Target a specific API with GRAPE_API=x.'
  task routes: :environment do
    all_routes = GrapeRakeTasks::Route.all_routes(Grape::API)
    processor = GrapeRakeTasks::Processor.new(all_routes)
    puts processor.format(GrapeRakeTasks::ConsoleFormatter.new, ENV['API'])
  end
end

