class_name Action

var e_event = []

func AddListener(listener):
	if (!e_event.has(listener)):
		e_event.append(listener)

func RemoveListener(listener):
	if (e_event != null):
		var index : int = e_event.find(listener)
		if (index >= 0):
			e_event.remove_at(index)

func Call(paramter):
	for e in e_event:
		e.call(paramter)
