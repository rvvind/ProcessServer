	workingDir=$PWD
	process=$1	
	
	n=14;
	dateminus14Days=$(date +"%Y-%m-%dT%T" --date="-$n days")

	cd /opt/IBM/WebSphere/AppServer/bin
	
	# AS016188: Updating the script to remove node parameter. 12/02/2013
	## AQP
	./wsadmin.sh -f /opt/IBM/WebSphere/AppServer/ProcessChoreographer/admin/deleteCompletedProcessInstances.py -cluster AppTarget -user svcBPM8ADMIN2 -password D4FpjI3U! -terminated -finished -failed -templateName AQP -completedBeforeLocal $dateminus14Days
	##QTC_Process
	./wsadmin.sh -f /opt/IBM/WebSphere/AppServer/ProcessChoreographer/admin/deleteCompletedProcessInstances.py -cluster AppTarget -user svcBPM8ADMIN2 -password D4FpjI3U! -terminated -finished -failed -templateName QTC_Process -completedBeforeLocal $dateminus14Days
	
	# AS016188: Updating the script to remove node parameter. 12/02/2013
	# if [ $process = "" ]; then 
	#	echo "Invalid argument. Supply template name. E.g: delBPCPI.sh AQP"
	# else
	
		# n=0;
		# dateminus14Days=$(date +"%Y-%m-%dT%T" --date="-$n days")

		# cd /opt/IBM/WebSphere/AppServer/bin
		
		# AS016188: Updating the script to remove node parameter. 12/02/2013
		# ./wsadmin.sh -f /opt/IBM/WebSphere/AppServer/ProcessChoreographer/admin/deleteCompletedProcessInstances.py -cluster AppTarget -user svcBPM8ADMIN2 -password D4FpjI3U! -terminated -finished -failed -templateName AQP -completedBeforeLocal $dateminus14Days
		
		# ./wsadmin.sh -f /opt/IBM/WebSphere/AppServer/ProcessChoreographer/admin/deleteCompletedProcessInstances.py -cluster AppTarget -user svcBPM8ADMIN2 -password D4FpjI3U! -terminated -finished -failed -templateName QTC_Process -completedBeforeLocal $dateminus14Days
		
		#./wsadmin.sh -f /opt/IBM/WebSphere/AppServer/ProcessChoreographer/admin/deleteCompletedProcessInstances.py -node WPS00 -cluster AppTarget -user svcBPM8ADMIN2 -password D4FpjI3U! -finished -templateName $process -completedBeforeLocal $dateminus14Days
		#./wsadmin.sh -f /opt/IBM/WebSphere/AppServer/ProcessChoreographer/admin/deleteCompletedProcessInstances.py -node WPS00 -cluster AppTarget -user svcBPM8ADMIN2 -password D4FpjI3U! -failed -templateName $process -completedBeforeLocal $dateminus14Days
	# fi
