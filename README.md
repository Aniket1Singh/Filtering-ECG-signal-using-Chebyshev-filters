# Filtering-ECG-signal-using-Chebyshev-filters
This is the MATLAB based code for filtering ECG signal (with required parameters) using Chebyshev Filters.

In this implementation, I utilized Chebyshev filters to filter an
electrocardiogram (ECG) signal. Initially, I employed a bandstop filter designed using Chebyshev filter to target noise centered around 180 Hz.
Subsequently, a lowpass filter was implemented using Chebyshev
filters to further refine the signal and eliminate any residual noise above 300 Hz. By applying these filters successively, I effectively cleaned the ECG signal, enhancing its clarity and removing unwanted noise. 
I generated visualizations to illustrate the frequency responses of the filters and to compare the original ECG signal with the final filtered output, both in the time and frequency domains.
