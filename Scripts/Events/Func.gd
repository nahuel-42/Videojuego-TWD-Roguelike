class_name Func

var e_event = null

func AddListener(listener):
	if (e_event == null):
		e_event = listener
	else:
		print("Error! Func Event")
		
func Call(paramter):
	return e_event.call(paramter)
