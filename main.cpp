
#include <iostream>
#include <drivers.h>
#include <Debug.h>
#include "pico/stdlib.h"

int main(int argc, char const *argv[])
{
    pico::Drivers *drivers = new pico::Drivers();
    // pico::Drivers *drivers = pico::Drivers::getDrivers();

    stdio_init_all();
    gpio_init(25);
    gpio_set_dir(25, GPIO_OUT);

    drivers->remote.initialize();
    while (1)
    {
        // Turn On LED
        gpio_put(25, 1); // Set pin 25 to high
        printf("LED on!\n");
        sleep_ms(250);
        // Turn Off LED
        gpio_put(25, 0); // Set pin 25 to high.
        printf("LED off!\n");
        sleep_ms(250);
        // try
        // {
        //     throw std::invalid_argument("received negative value");
        // }
        // catch (const std::invalid_argument &e)
        // {
        //     std::cout << "throw" << std::endl;
        // }


        // ====
        std::cout << "." << std::endl;
        drivers->remote.read(); // Reading the remote before we check if it is connected yet or not.
        if (drivers->remote.isConnected())
        {
            std::cout << "remote: " << drivers->remote.getChannel(pico::communication::serial::Remote::Channel::LEFT_HORIZONTAL) << std::endl;
        }
        tight_loop_contents();
    }
}
