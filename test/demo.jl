using TensorUniboard, PyCall
@pyimport tensorboard.backend.event_processing.event_accumulator as event_accumulator
EventAccumulatorPy = event_accumulator.EventAccumulator
event_file_path = "/Users/kai/projects/dialog-vae/code/log/20180817-02:38:45/events.out.tfevents.1534469925.kais-mbp-15.v2"
eapy = EventAccumulatorPy(event_file_path)
ea = EventAccumulator(eapy)
demo(ea)
