function reportResult(templateName, compareMethod, accuracy, confMatrix)
    fprintf('Template: %s\n', templateName);
    fprintf('Comparison method: %s\n',compareMethod);
    fprintf('Accuracy: %f\n', accuracy);
    fprintf('Confusion matrix\n');
    disp(confMatrix);
end

