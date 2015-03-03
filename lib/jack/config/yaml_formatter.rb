require "yaml"

module Jack
  module Config
    # Class does very specific formatting for the eb config files:
    #
    #   * Makes sure that the keys are sorted so we can compare them
    #   * It also scripts out the generated DateModified and DateCreated Metadata
    class YamlFormatter
      def process(file)
        data = YAML.load_file(file)
        data = strip_metadata_dates(data)
        dump = YAML.dump(data).gsub("!ruby/object:Hash", '')
        outfile = "#{file}.sorted"
        File.open(outfile, 'w') { |f| f.write(dump) }
        FileUtils.mv(outfile, file)
      end

      def strip_metadata_dates(data)
        metadata = data['EnvironmentConfigurationMetadata']
        if metadata
          metadata.delete('DateModified')
          metadata.delete('DateCreated')
        end
        data
      end
    end
  end
end