#define to_chat(target, message)                            target << (message)
#define to_world(message)                                   world << (message)
#define to_world_log(message)                               world.log << (message)
#define send_rsc(target, rsc_content, rsc_name)             target << browse_rsc(rsc_content, rsc_name)

#define islist(A) istype(A, /list)

#define testing(msg)

//print a warning message to world.log
#define WARNING(MSG) warning("[MSG] in [__FILE__] at line [__LINE__] src: [src] usr: [usr].")
/proc/warning(msg)
	msg = "## WARNING: [msg]"
	to_world_log(msg)