-module (element_cycler).
-include_lib("nitrogen_core/include/wf.hrl").
-include("records.hrl").

-export([
	reflect/0,
	render_element/1
]).

reflect() -> record_info(fields, cycler).

%%%% Transition: fade, wipe, flip
%%render_element(_Rec = #cycler{class=Class,
%%                images=Images0, style=Style,
%%                transition=flip, transition_time=_TransitionTime,
%%                linger_time=LingerTime}) ->

%% Transition: fade, wipe, flip
render_element(_Rec = #cycler{class=Class,
                images=Images0, style=Style,
                transition=Transition, transition_time=TransitionTime,
                linger_time=LingerTime}) ->
    Images = [wf:to_binary(I) || I <- Images0],

    {First,Second} = first_two(Images),

    ID = wf:temp_id(),

    case length(Images) of
        0 -> ok;
        1 -> ok;
        _ when Transition==flip ->
            %% only cycle if we have more than one icon
            wf:defer("init_cycler_flip('" ++ ID ++ "', " ++ wf:json_encode(Images) ++ ", " ++ wf:to_list(LingerTime) ++ ")");
        _ when Transition==blink ->
            wf:defer("init_cycler_blink('" ++ ID ++ "', " ++ wf:json_encode(Images) ++ "," ++ wf:to_list(LingerTime) ++ "," ++ wf:to_list(TransitionTime) ++ ")")
    end,

    %% always show the cycler_container, even if it's empty
    #panel{class=[cycler_container, Class], style=Style, body=[
        %% If first is empty, then we don't have anything to show, just blank out
        #panel{id=ID, show_if=(First=/=undefined), class=cycler_card, body=[
            #panel{class=cycler_face, body=[
                #image{image=First, style="max-width:100%; max-height:100%"}
            ]},
            #panel{show_if=(Second=/=undefined andalso Transition==flip), class=cycler_back, body=[
                #image{image=Second, style="max-width:100%; max-height:100%; "}
            ]}
        ]}
    ]}.

first_two([F,S|_]) -> {F,S};
first_two([F]) -> {F, undefined};
first_two([]) -> {undefined, undefined}.
