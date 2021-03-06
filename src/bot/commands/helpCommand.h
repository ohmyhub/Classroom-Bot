#pragma once

#include "command.h"

class HelpCommand : public Command {
public:
    void call(const std::vector<std::string>& parameters, MessageInfo* current);
    CommandInfo getCommandInfo();
};