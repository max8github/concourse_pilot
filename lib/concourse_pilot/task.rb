require "yaml"

module ConcoursePilot
  class Task
    REQUIRED_PARAMETERS = %w[platform image_resource run]
    OPTIONAL_PARAMETERS = %w[inputs outputs caches params rootfs_uri container_limits]

    def self.from_yaml(yaml_string)
      data = YAML.safe_load(yaml_string)
      task = Task.new(data)
      task if task.valid?
    end

    def initialize(data)
      @data = data
    end

    def valid?
      REQUIRED_PARAMETERS.each do |key|
        return false if @data[key].nil?
      end

      unexpected_keys = @data.keys - REQUIRED_PARAMETERS - OPTIONAL_PARAMETERS
      unexpected_keys.empty?
    end

    def inputs(flat = false)
      list_items("inputs", flat)
    end

    def outputs(flat = false)
      list_items("outputs", flat)
    end

    private

    def list_items(category, flat)
      if flat
        begin
          @data[category].map { |item| item["name"] }
        rescue
          []
        end
      else
        @data[category] ||= []
      end
    end
  end
end
