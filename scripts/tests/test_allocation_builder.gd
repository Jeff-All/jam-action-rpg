extends Control

var builder: AllocationBuilder

func _ready():
	builder = AllocationBuilder.new()

func _on_execute_pressed():
	var allocations = builder.build_allocations()
	print("Begin")
	var count = 0
	var party_cr_counts = {}
	print("{")
	for party in allocations:
		#print("party: %s" % party)
		party_cr_counts[party] = {}
		print("\t%s: {" % [party])
		for cr in allocations[party]:
			#print("cr: %s" % cr)
			party_cr_counts[party][cr] = 0
			print("\t\t%s: {" % [cr])
			for enemies in allocations[party][cr]:
				#print("enemies: %s" % enemies)
				print("\t\t\t%s: [" % [enemies])
				for cur in allocations[party][cr][enemies]:
					#print("P[%s]CR[%s]E[%s]%s" % [party, cr, enemies, cur])
					print("\t\t\t\t%s," % [cur])
					count += 1
					party_cr_counts[party][cr] += 1
				print("\t\t\t],")
				#for allocation in allocations[party][cr][enemies]:
				#	print("%s" % allocation)
			print("\t\t},")
		print("\t},")
	print("}")
	for party in party_cr_counts:
		for cr in party_cr_counts[party]:
			print("%s.%s->%s" % [party, cr, party_cr_counts[party][cr]])
	print("Fin: %s" % count)

func print_allocation(allocation) -> String:
	var to_return = {}
	for key in allocation:
		var cur = allocation[key]
		if cur is Dictionary:
			pass
		else:
			to_return = to_return + "%s:%s," % [key, cur]
	return ""
