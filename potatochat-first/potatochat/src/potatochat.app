
 
{application, potatochat, [
    {description, ""},
    {vsn, "1"},
    {registered, []}, %listing all registered processes
    {applications, [
        kernel, %default 
        stdlib, % default
        inets, %
        ssl,
        bson, % jasson giffy
        crypto,
        mongodb % data base
    ]},
    {mod, {potatochat_app, []}},  
    {env, []}
]}.

%%  Copywright M65V / 2016