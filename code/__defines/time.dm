#define SECONDS *10

#define MINUTES SECONDS*60

#define HOURS MINUTES*60

#define MIDNIGHT_ROLLOVER		864000	//number of deciseconds in a day

#define DS2TICKS(DS) ((DS)/world.tick_lag)

GLOBAL_VAR_INIT(midnight_rollovers, 0)
GLOBAL_VAR_INIT(rollovercheck_last_timeofday, 0)
/proc/update_midnight_rollover()
	if (world.timeofday < GLOB.rollovercheck_last_timeofday) //TIME IS GOING BACKWARDS!
		return GLOB.midnight_rollovers++
	return GLOB.midnight_rollovers