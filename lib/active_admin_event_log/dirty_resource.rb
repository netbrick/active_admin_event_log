module ActiveAdminEventLog
  class DirtyResource
    def initialize(resource, para)
      # Init resource
      @res = resource

      # History processing!
      @history = []

      # Start processing
      @hash_report = process(resource, para[resource.class.name.underscore])
    end

    def hash_report
      @hash_report
    end

    private
      def process(resource, para)
        # Nothing when resource was created
        return {} if @history.include? resource

        # Add resource to history
        @history << resource

        # New hash
        changed_data = {}

        # Changed resources - first level + test inherited!
        resource.changed.each do |change_item|
          changed_data[change_item] = resource.send("#{change_item}_change")
        end

        # End if para is nil!
        return changed_data if para.nil?

        # Get all associtaions
        resource.class.reflect_on_all_associations.each do |asc|
          # Get this associtaions from attribute
          param_new = para[asc.name] || para["#{asc.name}_attributes"]

          # Params not contains this associations - skip
          next unless param_new

          # Set changed data!
          changed_data[asc.name] = []

          # Get items?!
          Array.wrap(resource.send("#{asc.name}")).each do |item|
            # Test
            ret = process(item, param_new)

            # Skip when nothing!
            next if ret.size == 0

            # Add to list!
            ret[:resource_id] = (item.new_record?) ? "new_record" : item.try(:id)

            # Save!
            changed_data[asc.name] << ret
          end

          # Delete if empty!
          changed_data.delete(asc.name) if change_data[asc.name].size == 0
        end

        # Return
        changed_data
      end
  end
end
