function [waveform, velocity, peak_velocity, t] ...
    = saccade_model(t, eta, c, amplitude, t0, s0)

% [waveform, velocity, peak_velocity] = SACCADE_MODEL(t, eta, c, amplitude)
%
% A parametric model for saccadic eye movement.
% This function simulates saccade waveforms using a parametric model.
% The saccade model corresponds to the 'main sequence' formula:
%    Vp = eta*(1 - exp(-A/c))
% where Vp is the peak saccadic velocity and A is the saccadic amplitude.
%
% Input:
%   t         : time axis (sec)
%   eta       : main sequence parameter (deg/sec)
%   c         : main sequence parameter (no units)
%   amplitude : amplitude of saccade (deg)
% 
% Output:
%   waveform      : time series of saccadic angle
%   velocity      : time series of saccadic angular velocity
%   peak_velocity : peak velocity of saccade
%
% % Example:
%   Fs = 2000;                % sampling rate (samples/sec)
%   t = -0.1:1/Fs:0.1;        % time axis (sec)
%   eta = 600;                % (degree/sec)
%   c = 6;                    % (no units)
%   amplitude = 9.5;          % (degree)
%   [waveform, velocity] = saccade_model(t, eta, c, amplitude);
%
%   figure(1), clf
%   plot(1000*t, waveform)
%   xlabel('Time (ms)')
%   ylabel('Angle (deg)')
%   title('Saccade waveform')

% Reference:
% W. Dai, I. Selesnick, J.-R. Rizzo, J. Rucker and T. Hudson.
% 'A parametric model for saccadic eye movement.'
% IEEE Signal Processing in Medicine and Biology Symposium (SPMB), December 2016.
% DOI: 10.1109/SPMB.2016.7846860.

% Weiwei Dai
% May 3, 2017

if nargin < 1
  t = -0.1:0.0005:0.1;     % time axis (sec)
  eta = 600;               % (degree/sec)
  c = 6;                   % (no units)
  amplitude = 9.5;         % (degree)
end

tau = amplitude/eta;       % tau: amplitude parameter (amplitude = eta*tau)

% Default off-set values
if ~exist('t0', 'var')
    t0 = -tau/2;           % t0: saccade onset time
end
if ~exist('s0', 'var')
    s0 = 0;                % s0: initial saccade angle
end

f = @(t) t.*(t>=0) + 0.25*exp(-2*t).*(t>=0) + 0.25*exp(2*t).*(t<0);
f_vel = @(t) (t>=0) - 0.5*exp(-2*t).*(t>=0) + 0.5*exp(2*t).*(t<0);
fpvel = @(A) eta*(1 - exp(-A/c)); 

waveform = c*f(eta*(t - t0)/c) - c*f(eta*(t - t0 - tau)/c) + s0;
velocity = eta*f_vel(eta*(t - t0)/c) - eta*f_vel(eta*(t - t0 - tau)/c);
peak_velocity = fpvel(amplitude);

end

