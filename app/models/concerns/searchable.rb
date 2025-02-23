module Searchable
  # == Extensions ===========================================================
  extend ActiveSupport::Concern

  # == Constants ============================================================

  # == Attributes ===========================================================

  # == Relationships ========================================================

  # == Validations ==========================================================

  # == Scopes ===============================================================

  # == Callbacks ============================================================
  included do
    after_commit :index_document, on: [ :create, :update ]
    after_destroy :delete_document
  end

  # == Class Methods ========================================================
  class_methods do
    def index_name = name.underscore.pluralize

    def searchable_fields = [ :id ]

    def reindex_all
      find_each(&:index_document)
    end

    def search(query)
      response = OpenSearchClient.search(
        index: index_name,
        body: {
          query: {
            multi_match: {
              query: query,
              fields: searchable_fields.map(&:to_s),
              fuzziness: "AUTO"
            }
          }
        }
      )

      ids = response["hits"]["hits"].map { |hit| hit["_id"] }

      where(id: ids).in_order_of(:id, ids)
    end

    def create_index!(force: false)
      OpenSearchClient.indices.delete(index: index_name) if force && OpenSearchClient.indices.exists?(index: index_name)

      OpenSearchClient.indices.create(
        index: index_name,
        body: {
          settings: { number_of_shards: 1 },
          mappings: {
            properties: searchable_fields.index_with { |_f| { type: "text" } }
          }
        }
      )
    end
  end
  # == Instance Methods =====================================================

  def as_indexed_json
    as_json(only: self.class.searchable_fields)
  end

  def index_document
    OpenSearchClient.index(
      index: self.class.index_name,
      id: id,
      body: as_indexed_json
    )
  end

  def delete_document
    OpenSearchClient.delete(
      index: self.class.index_name,
      id: id
    ) rescue nil
  end
end
