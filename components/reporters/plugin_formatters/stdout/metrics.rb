=begin
    Copyright 2010-2015 Tasos Laskos <tasos.laskos@arachni-scanner.com>

    This file is part of the Arachni Framework project and is subject to
    redistribution and commercial restrictions. Please see the Arachni Framework
    web site for more information on licensing and terms of use.
=end

class Arachni::Reporters::Stdout

# @author Tasos "Zapotek" Laskos <tasos.laskos@arachni-scanner.com>
class PluginFormatters::Metrics < Arachni::Plugin::Formatter

    def run
        print_ok 'General'
        general = results['general']
        print_info "Egress traffic:  #{Arachni::Utilities.bytes_to_megabytes general['egress_traffic']}MB"
        print_info "Ingress traffic: #{Arachni::Utilities.bytes_to_megabytes general['ingress_traffic']}MB"
        print_info "Uses HTTP:       #{general['uses_http']}"
        print_info "Uses HTTPS:      #{general['uses_https']}"
        print_line

        print_ok 'Scan'
        scan = results['scan']
        print_info "Duration:      #{Arachni::Utilities.seconds_to_hms scan['duration']}"
        print_info "Authenticated: #{scan['authenticated']}"
        print_line

        print_ok 'HTTP'
        http = results['http']
        print_info "Minimum response time: #{http['response_time_min'].round( 4 )}s"
        print_info "Maximum response time: #{http['response_time_max'].round( 4 )}s"
        print_info "Average response time: #{http['response_time_average'].round( 4 )}s"
        print_line

        print_ok 'Resources'
        resource = results['resource']
        print_info "Binary:             #{resource['binary']}"
        print_info "Without parameters: #{resource['without_parameters']}"
        print_info "With parameters:    #{resource['with_parameters']}"
        print_line

        print_ok 'Elements'
        element = results['element']
        print_info "Links:              #{element['links']}"
        print_info "Forms:              #{element['forms']}"
        print_info " -- with nonces:    #{element['has_forms_with_nonces']}"
        print_info " -- with passwords: #{element['has_forms_with_passwords']}"
        print_info "Cookies:            #{element['cookies']}"
        print_info "Headers:            #{element['headers']}"
        print_info "XMLs:               #{element['xmls']}"
        print_info "JSONs:              #{element['jsons']}"
        print_info "Total input names:  #{element['input_names_total']}"
        print_info "Unique input names: #{element['input_names_unique']}"
        print_line

        print_ok 'DOM'
        dom = results['dom']
        print_info "Event listeners: #{dom['event_listeners']}"
        print_info "SWF objects:     #{dom['swf_objects']}"
        print_line

        print_ok 'Platforms'
        results['platforms'].each do |type, platforms|
            next if platforms.empty?

            platforms = platforms.map { |platform| Arachni::Platform::Manager::PLATFORM_NAMES[platform.to_sym] }
            print_info "#{Arachni::Platform::Manager::TYPES[type.to_sym]}: #{platforms.join( ', ' )}"
        end
    end

end
end
