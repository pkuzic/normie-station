#define to_chat(target, message)                            target << (message)
#define to_world(message)                                   world << (message)
#define to_world_log(message)                               world.log << (message)
#define send_rsc(target, rsc_content, rsc_name)             target << browse_rsc(rsc_content, rsc_name)

#define islist(A) istype(A, /list)