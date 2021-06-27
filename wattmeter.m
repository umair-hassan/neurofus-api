classdef wattmeter < handle
    %   Summary of RF Wattmeter Sonic Concepts 23B and 24B class goes here
    %   Detailed explanation goes here
    
    properties (SetAccess = private)
       port
       connected = 0; %Default value of connected set to 0 to make sure the user connects the port
       scan
   end
    properties (Dependent)
        version
        start %Future Release for continous sampling
        stop  %Future Release for continous sampling
    end
    properties
        id
        power
        volts
        amps
        powervoltagecurrent
        impedance
        phase
        zero_error
        digital_filter_intensity
        integeration_time
%         digital_filter_setpoint
%         integeration_time_setpoint
    end
    methods
        
        function obj = wattmeter(PortID)
            % PortID <char> defines the serail port id on your computer
            % Example: nfs=wattmeter('COM8');
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
        function clear(obj)
            try delete(instrfindall), catch, end
        end
        %% id
        function id = get.id(obj)
            % Documentation goes here
            %assert
            carriage        ='CR';
            key             ='*IDN?';
            value           ='';
            id=obj.process_command(key,value,carriage);
            obj.id=id;
            errorOrSuccess=1;
            deviceResponse=[];
        end
        
        %% power
        function power = get.power(obj)
            % Documentation goes here
            %assert
            carriage        ='CR';
            key             ='POW?';
            value           ='';
            power=obj.process_command(key,value,carriage);
            obj.power=power;
            errorOrSuccess=1;
            deviceResponse=[];
        end
        
        %% volts
        function volts = get.volts(obj)
            % Documentation goes here
            %assert
            carriage        ='CR';
            key             ='VOLT?';
            value           ='';
            volts=obj.process_command(key,value,carriage);
            obj.volts=volts;
            errorOrSuccess=1;
            deviceResponse=[];
        end
        
        %% amps
        function amps = get.amps(obj)
            % Documentation goes here
            %assert
            carriage        ='CR';
            key             ='AMP?';
            value           ='';
            amps=obj.process_command(key,value,carriage);
            obj.amps=amps;
            errorOrSuccess=1;
            deviceResponse=[];
        end
        
        %% powervoltagecurrent
        function powervoltagecurrent = get.powervoltagecurrent(obj)
            % Documentation goes here
            %assert
            carriage        ='CR';
            key             ='ALL?';
            value           ='';
            powervoltagecurrent=obj.process_command(key,value,carriage);
            obj.powervoltagecurrent=powervoltagecurrent;
            errorOrSuccess=1;
            deviceResponse=[];
        end
        
        %% impedance
        function impedance = get.impedance(obj)
            % Documentation goes here
            %assert
            carriage        ='CR';
            key             ='Z?';
            value           ='';
            impedance=obj.process_command(key,value,carriage);
            obj.impedance=impedance;
            errorOrSuccess=1;
            deviceResponse=[];
        end
        
        %% phase
        function phase = get.phase(obj)
            % Documentation goes here
            %assert
            carriage        ='CR';
            key             ='ANG?';
            value           ='';
            phase=obj.process_command(key,value,carriage);
            obj.phase=phase;
            errorOrSuccess=1;
            deviceResponse=[];
        end
        
        %% zero
        function zero_error = get.zero_error(obj)
            % Documentation goes here
            %assert
            carriage        ='CR';
            key             ='ZERO';
            fwrite(obj.port,key,"char");
            fprintf(obj.port,carriage);
            zero_error=true;
            errorOrSuccess=1;
            deviceResponse=[];
        end
        
        %% digital_filter_intensity
        
        

        function digital_filter_intensity_out = set_digital_filter_intensity(obj,digital_filter_intensity)
            % digital_filter_intensity is 1 to 5 integer
            %assert
            carriage        ='CR';
            key             ='DF';
            value           =num2str(digital_filter_intensity);
            
            obj.digital_filter_intensity=digital_filter_intensity;
            digital_filter_intensity_out=obj.digital_filter_intensity;
            
            obj.process_command(key,value,carriage);
            
        end
        
        %% integeration_time
        
        function integeration_time_out = set_integeration_time(obj,integeration_time)
            % integeration_time is 1 to 4, it sets the length of the
            % measurement integeration time
            %assert
            carriage        ='CR';
            key             ='IT';
            value           =num2str(integeration_time);
            obj.integeration_time=integeration_time;
            obj.process_command(key,value,carriage);
            integeration_time_out=obj.integeration_time;
            errorOrSuccess=1;
            deviceResponse=[];
        end

        %% Terminal
        
        function process_out=process_command(obj,key,value,carriage)
            if isempty(value)
                fwrite(obj.port,key,"char");
                fprintf(obj.port,carriage);
                process_out=fscanf(obj.port);
            else
                fwrite(obj.port,[key '=' value],"char");
                fprintf(obj.port,carriage);
                process_out=true;
            end
        end

    end
end


