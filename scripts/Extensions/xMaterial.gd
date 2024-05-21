class_name xMaterial

static func set_shader_vector_component(material, vector_name, component_index, value):
	var vector = material.get_shader_parameter(vector_name)
	vector[component_index] = value
	material.set_shader_parameter(vector_name, vector)
