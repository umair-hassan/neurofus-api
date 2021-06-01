classdef wattmeter < handle
    %   Summary of RF Wattmeter Sonic Concepts 23B and 24B class goes here
    %   Detailed explanation goes here
    
    properties (SetAccess = private)
       port
       connected = 0; %Default value of connected set to 0 to make sure the user connects the port
   end
    properties (Dependent)
        version
        start
        stop
    end
    properties
        id
        power
        volts
        amps
        all
        impedence
        phase
        zero_error
        digital_filter
        integeration_time

    end
    methods
        
        function obj = wattmeter(PortID)
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
        %% power
        function power = get.power(obj)
            power = obj.power;
        end
        function obj = set.power(obj, power)
            % Documentation goes here
            %assert
            carriage        ='CR';
            key             ='BURST';
            value           =num2str(power);
            obj.power=power;
            obj.process_command(key,value,carriage);
            errorOrSuccess=1;
            deviceResponse=[];
        end
        %% volts
        function volts = get.volts(obj)
            volts = obj.volts;
        end
        function obj = set.volts(obj, volts)
            % Documentation goes here
            %assert
            carriage        ='CR';
            key             ='BURST';
            value           =num2str(volts);
            obj.volts=volts;
            obj.process_command(key,value,carriage);
            errorOrSuccess=1;
            deviceResponse=[];
        end
        %% amps
        function amps = get.amps(obj)
            amps = obj.amps;
        end
        function obj = set.amps(obj, amps)
            % Documentation goes here
            %assert
            carriage        ='CR';
            key             ='BURST';
            value           =num2str(amps);
            obj.amps=amps;
            obj.process_command(key,value,carriage);
            errorOrSuccess=1;
            deviceResponse=[];
        end
        %% impedence
        function amps = get.amps(obj)
            amps = obj.amps;
        end
        function obj = set.amps(obj, amps)
            % Documentation goes here
            %assert
            carriage        ='CR';
            key             ='BURST';
            value           =num2str(amps);
            obj.amps=amps;
            obj.process_command(key,value,carriage);
            errorOrSuccess=1;
            deviceResponse=[];
        end
        %% phase
        function amps = get.amps(obj)
            amps = obj.amps;
        end
        function obj = set.amps(obj, amps)
            % Documentation goes here
            %assert
            carriage        ='CR';
            key             ='BURST';
            value           =num2str(amps);
            obj.amps=amps;
            obj.process_command(key,value,carriage);
            errorOrSuccess=1;
            deviceResponse=[];
        end
        %% zeroerror
        function amps = get.amps(obj)
            amps = obj.amps;
        end
        function obj = set.amps(obj, amps)
            % Documentation goes here
            %assert
            carriage        ='CR';
            key             ='BURST';
            value           =num2str(amps);
            obj.amps=amps;
            obj.process_command(key,value,carriage);
            errorOrSuccess=1;
            deviceResponse=[];
        end
        %% digitalfilter
        function amps = get.amps(obj)
            amps = obj.amps;
        end
        function obj = set.amps(obj, amps)
            % Documentation goes here
            %assert
            carriage        ='CR';
            key             ='BURST';
            value           =num2str(amps);
            obj.amps=amps;
            obj.process_command(key,value,carriage);
            errorOrSuccess=1;
            deviceResponse=[];
        end
        %% integeration_time
        function amps = get.amps(obj)
            amps = obj.amps;
        end
        function obj = set.amps(obj, amps)
            % Documentation goes here
            %assert
            carriage        ='CR';
            key             ='BURST';
            value           =num2str(amps);
            obj.amps=amps;
            obj.process_command(key,value,carriage);
            errorOrSuccess=1;
            deviceResponse=[];
        end
        %% all
        function amps = get.amps(obj)
            amps = obj.amps;
        end
        function obj = set.amps(obj, amps)
            % Documentation goes here
            %assert
            carriage        ='CR';
            key             ='BURST';
            value           =num2str(amps);
            obj.amps=amps;
            obj.process_command(key,value,carriage);
            errorOrSuccess=1;
            deviceResponse=[];
        end
        %% id
        function amps = get.amps(obj)
            amps = obj.amps;
        end
        function obj = set.amps(obj, amps)
            % Documentation goes here
            %assert
            carriage        ='CR';
            key             ='BURST';
            value           =num2str(amps);
            obj.amps=amps;
            obj.process_command(key,value,carriage);
            errorOrSuccess=1;
            deviceResponse=[];
        end
        %% start
        function amps = get.amps(obj)
            amps = obj.amps;
        end
        function obj = set.amps(obj, amps)
            % Documentation goes here
            %assert
            carriage        ='CR';
            key             ='BURST';
            value           =num2str(amps);
            obj.amps=amps;
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


