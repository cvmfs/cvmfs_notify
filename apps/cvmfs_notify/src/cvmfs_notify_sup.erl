%%%-------------------------------------------------------------------
%% @doc cvmfs_notify top level supervisor.
%% @end
%%%-------------------------------------------------------------------

-module(cvmfs_notify_sup).

-behaviour(supervisor).

%% API
-export([start_link/1]).

%% Supervisor callbacks
-export([init/1]).

-define(SERVER, ?MODULE).

%%====================================================================
%% API functions
%%====================================================================

start_link(Args) ->
    supervisor:start_link({local, ?SERVER}, ?MODULE, Args).

%%====================================================================
%% Supervisor callbacks
%%====================================================================

init(_Args) ->
    SupervisorSpecs = #{strategy => one_for_all,
                        intensity => 5,
                        period => 5},
    WorkerSpecs = [
      #{id => event_manager,
        start => {event_manager, start_link, []},
        restart => permanent,
        shutdown => 2000,
        type => worker,
        modules => [event_manager]}
     ],
    {ok, {SupervisorSpecs, WorkerSpecs} }.

%%====================================================================
%% Internal functions
%%====================================================================
