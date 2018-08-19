struct EventAccumulator
  eapy::PyObject
end
#  EventAccumulator(event_file_path::String) = EventAccumulator(EventAccumulatorPy(event_file_path))
reload!(ea::EventAccumulator) = ea.eapy["Reload"]()
tags(ea::EventAccumulator) = ea.eapy["Tags"]()
# Below returns a 3-tuple of time, step, and value
scalars(ea::EventAccumulator, name::AbstractString) = ea.eapy["Scalars"](name)

