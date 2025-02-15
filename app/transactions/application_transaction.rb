class ApplicationTransaction
  include Dry::Transaction

  def self.call(...)
    new.call(...)
  end

  def self.validate(contract, full: true)
    step :validate

    define_method :validate do |input, params = {}|
      result = contract.new(**params).call(input)

      if result.success?
        Success(result.to_h)
      else
        Failure(result.errors(full:).to_h)
      end
    end
  end
end
