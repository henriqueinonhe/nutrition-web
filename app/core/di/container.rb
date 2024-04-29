# frozen_string_literal: true

class Di::Container
  def self.class_resolver(factory)
    [:Class, factory]
  end

  def self.value_resolver(value)
    [:Value, value]
  end

  def initialize(**resolvers)
    # TODO: Validate resolvers

    @resolvers = resolvers

    @services = resolvers.transform_values { nil }
  end

  def get(service_name)
    cached_service = @services[service_name]

    return cached_service if cached_service

    service = resolve_service(service_name)

    @services[service_name] = service

    service
  end

  def derive(**resolvers)
    Di::Container.new(**@resolvers.merge(resolvers))
  end

  private

  def resolve_service(service_name)
    (resolver_type, resolver_factory) = @resolvers[service_name]

    case resolver_type
    when :Class
      resolve_class(service_name, resolver_factory)
    when :Value
      resolve_value(service_name, resolver_factory)
    end
  end

  def resolve_class(service_name, resolver_factory)
    dependencies_names = resolver_factory.instance_method(:initialize).parameters.map { |_type, name| name }

    dependencies = dependencies_names.index_with { |name| get(name) }

    service = resolver_factory.new(**dependencies)

    @services[service_name] = service
  end

  def resolve_value(service_name, value)
    service = value

    @services[service_name] = service

    service
  end
end
