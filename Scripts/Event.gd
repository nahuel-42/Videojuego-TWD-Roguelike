class_name Event

var e_event = []

func AddListener(listener):
	if (!e_event.has(listener)):
		e_event.append(listener)

func Call(paramter):
	for e in e_event:
		e.call(paramter)
