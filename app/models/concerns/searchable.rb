module Searchable
  extend ActiveSupport::Concern
  
  included do
    #
    # ==== Example
    #
    #   Bucket.find_all_by params[:s]
    #     # => [<Course=[]>, <Vault=[]>, etc]
    #
    def self.find_all_by search_term
      self.pluck(:bucketable_type).uniq.map { |table|
        _find_all_by table: table, term: search_term 
      }.compact.flatten
    end
  end
  
  def _find_all_by table:, term:
    begin
      table
        .titleize
        .constantize
        .where("title like %#{term}%")
    rescue
      []
    end
  end
  
end