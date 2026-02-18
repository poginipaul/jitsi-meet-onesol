admins = {
    

    

    "focus@auth.meet.jitsi",
    "jvb@auth.meet.jitsi"
}

unlimited_jids = {
    "focus@auth.meet.jitsi",
    "jvb@auth.meet.jitsi"
}

plugin_paths = { "/prosody-plugins-custom", "/prosody-plugins/", "/prosody-plugins-contrib" }

muc_mapper_domain_base = "video.onesolutions.net";
muc_mapper_domain_prefix = "muc";

recorder_prefixes = { "recorder@hidden.meet.jitsi" };

transcriber_prefixes = { "transcriber@hidden.meet.jitsi" };

http_default_host = "video.onesolutions.net"







consider_bosh_secure = true;
consider_websocket_secure = true;


smacks_max_unacked_stanzas = 5;
smacks_hibernation_time = 60;
smacks_max_old_sessions = 1;




VirtualHost "video.onesolutions.net"

    authentication = "jitsi-anonymous"

    ssl = {
        key = "/config/certs/video.onesolutions.net.key";
        certificate = "/config/certs/video.onesolutions.net.crt";
    }
    modules_enabled = {
        "bosh";
        "features_identity";
        
        "websocket";
        "smacks"; -- XEP-0198: Stream Management
        
        "conference_duration";
        
        "muc_lobby_rooms";
        
        
        "muc_breakout_rooms";
        
        
        
        
        

    }

    main_muc = "muc.video.onesolutions.net"
    
    lobby_muc = "lobby.video.onesolutions.net"
    
    

    

    
    breakout_rooms_muc = "breakout.video.onesolutions.net"
    

    c2s_require_encryption = true

    

    

VirtualHost "auth.meet.jitsi"
    ssl = {
        key = "/config/certs/auth.meet.jitsi.key";
        certificate = "/config/certs/auth.meet.jitsi.crt";
    }
    modules_enabled = {
        "limits_exception";
        "smacks";
    }
    authentication = "internal_hashed"
    smacks_hibernation_time = 15;



Component "internal-muc.video.onesolutions.net" "muc"
    storage = "memory"
    modules_enabled = {
        "muc_hide_all";
        "muc_filter_access";
        }
    restrict_room_creation = true
    muc_filter_whitelist="auth.meet.jitsi"
    muc_room_locking = false
    muc_room_default_public_jids = true
    muc_room_cache_size = 1000
    muc_tombstones = false
    muc_room_allow_persistent = false

Component "muc.video.onesolutions.net" "muc"
    restrict_room_creation = true
    storage = "memory"
    modules_enabled = {
        "muc_hide_all";
        "muc_meeting_id";
        
        "muc_domain_mapper";
        
        "muc_password_whitelist";
        
    }

    -- The size of the cache that saves state for IP addresses
    rate_limit_cache_size = 10000;

    muc_room_cache_size = 10000
    muc_room_locking = false
    muc_room_default_public_jids = true
    
    muc_password_whitelist = {
        "focus@auth.meet.jitsi";
    }
    muc_tombstones = false
    muc_room_allow_persistent = false

Component "focus.video.onesolutions.net" "client_proxy"
    target_address = "focus@auth.meet.jitsi"

Component "speakerstats.video.onesolutions.net" "speakerstats_component"
    muc_component = "muc.video.onesolutions.net"


Component "endconference.video.onesolutions.net" "end_conference"
    muc_component = "muc.video.onesolutions.net"



Component "avmoderation.video.onesolutions.net" "av_moderation_component"
    muc_component = "muc.video.onesolutions.net"



Component "lobby.video.onesolutions.net" "muc"
    storage = "memory"
    restrict_room_creation = true
    muc_tombstones = false
    muc_room_allow_persistent = false
    muc_room_cache_size = 10000
    muc_room_locking = false
    muc_room_default_public_jids = true
    modules_enabled = {
        "muc_hide_all";
    }

    


Component "breakout.video.onesolutions.net" "muc"
    storage = "memory"
    restrict_room_creation = true
    muc_room_cache_size = 10000
    muc_room_locking = false
    muc_room_default_public_jids = true
    muc_tombstones = false
    muc_room_allow_persistent = false
    modules_enabled = {
        "muc_hide_all";
        "muc_meeting_id";
        }


Component "metadata.video.onesolutions.net" "room_metadata_component"
    muc_component = "muc.video.onesolutions.net"
    breakout_rooms_component = "breakout.video.onesolutions.net"




Component "polls.video.onesolutions.net" "polls_component"
