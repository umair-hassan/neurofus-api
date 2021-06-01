classdef neurofus < handle
    %   Summary of NEUROFUS class goes here
    %   Detailed explanation goes here
    
    properties (SetAccess = private)
       port
       connected = 0; %Default value of connected set to 0 to make sure the user connects the port
   end
    properties (Dependent)
        version
        armed
        start
        stop
    end
    properties
        global_frequency
        global_power
        burst_length
        period
        timer
        focus
        ramp_mode
        ramp_length
        system_state
        trigger_mode
        extrafield
        local
        volume
        screen_recalibrate
        frequency_channel_1
        frequency_channel_2
        frequency_channel_3
        frequency_channel_4
        power_channel_1
        power_channel_2
        power_channel_3
        power_channel_4
        phase_channel_1
        phase_channel_2
        phase_channel_3
        phase_channel_4
    end
    methods
        
        function obj = neurofus(PortID)
            % PortID <char> defines the serail port id on your computer
            % Example: nfs=neurofus('COM6');
            try delete(instrfindall), catch, end
            P = serial(PortID);
            P.BaudRate = 115200;
            P.DataBits = 8;
            P.Parity = 'none';
            obj.port = P;
        end
        function [errorOrSuccess, deviceStatus] = connect(obj)
            %% Check Input Validity
            if nargin <1
                error('Not Enough Input Arguments');
            end
            
            %% Open The Port
            pause(2);
            fopen(obj.port);
            obj.port.Terminator='CR';
            if ~(strcmp (obj.port.Status,'closed'))
                obj.connected = 1;
                errorOrSuccess = ~ obj.connected;
                deviceStatus = [];
            end
            
            %Initialize all indenpendent properties
            
            %Print TPO version
            
        end
        function [errorOrSuccess, deviceResponse] = disconnect(obj)
            %% Check Input Validity
            if nargin <1
                error('Not Enough Input Arguments');
            end
            
            %% Close The Port
            fclose(obj.port);
            if (strcmp (obj.port.Status,'closed'))
                obj.connected = 0;
                errorOrSuccess = obj.connected;
                deviceResponse = [];
            end
            
        end
        %% arm
        function obj = arm(obj)
            obj.armed = 'yes';
        end
        
        %% disarm
        function obj = disarm(obj)
            obj.armed = 'no';
        end
        %% start
        %% stop
        %% burst_length
        function burst_length = get.burst_length(obj)
            burst_length = obj.burst_length;
        end
        function obj = set.burst_length(obj, burst_length)
            % Documentation goes here
            %assert
            carriage        ='CR';
            key             ='BURST';
            value           =num2str(burst_length);
            obj.burst_length=burst_length;
            obj.process_command(key,value,carriage);
            errorOrSuccess=1;
            deviceResponse=[];
        end
        %% period
        function period = get.period(obj)
            period = obj.period;
        end
        function obj = set.period(obj, period)
            % Documentation goes here
            %assert
            carriage        ='CR';
            key             ='PERIOD';
            value           =num2str(period);
            obj.period=period;
            obj.process_command(key,value,carriage);
            errorOrSuccess=1;
            deviceResponse=[];
        end
        %% timer
        function timer = get.timer(obj)
            timer = obj.timer;
        end
        function obj = set.timer(obj, timer)
            % Documentation goes here
            %assert
            carriage        ='CR';
            key             ='TIMER';
            value           =num2str(timer);
            obj.timer=timer;
            obj.process_command(key,value,carriage);
            errorOrSuccess=1;
            deviceResponse=[];
        end
        %% focus
        function focus = get.focus(obj)
            focus = obj.focus;
        end
        function obj = set.focus(obj, focus)
            % Documentation goes here
            %assert
            carriage        ='CR';
            key             ='FOCUS';
            value           =num2str(focus);
            obj.focus=focus;
            obj.process_command(key,value,carriage);
            errorOrSuccess=1;
            deviceResponse=[];
        end
        %% system_state
        function system_state = get.system_state(obj)
            system_state = obj.system_state;
        end
        function obj = set.system_state(obj, system_state)
            % Documentation goes here
            %assert
            carriage        ='CR';
            key             ='SYSTEMSTATE';
            value           =num2str(system_state);
            obj.system_state=system_state;
            obj.process_command(key,value,carriage);
            errorOrSuccess=1;
            deviceResponse=[];
        end
        %% trigger_mode
        function trigger_mode = get.trigger_mode(obj)
            trigger_mode = obj.trigger_mode;
        end
        function obj = set.trigger_mode(obj, trigger_mode)
            % Documentation goes here
            %assert
            carriage        ='CR';
            key             ='TRIGGERMODE';
            value           =num2str(trigger_mode);
            obj.trigger_mode=trigger_mode;
            obj.process_command(key,value,carriage);
            errorOrSuccess=1;
            deviceResponse=[];
        end
        %% global_power
        function global_power = get.global_power(obj)
            global_power = obj.global_power;
        end
        function obj = set.global_power(obj, global_power)
            % Documentation goes here
            %assert
            carriage        ='CR';
            key             ='GLOBALPOWER';
            value           =num2str(global_power);
            obj.global_power=global_power;
            obj.process_command(key,value,carriage);
            errorOrSuccess=1;
            deviceResponse=[];
        end
        %% Terminal
        
        function obj=process_command(obj,key,value,carriage)
            fwrite(obj.port,[key '=' value],"char");
            fprintf(obj.port,carriage);
        end
        
        
    end
end


