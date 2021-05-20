
#include "menu.h"

int Menu::eventloop() {
	SDL_Event event;
	int event_x, event_y;
	while(SDL_PollEvent(&event)) {
		switch(event.type) {
		case SDL_KEYDOWN:
				if(event.key.keysym.sym == SDLK_RETURN)
					return handleSelection();
				else if(event.key.keysym.sym == SDLK_UP)
					menuItemUp();
				else if(event.key.keysym.sym == SDLK_DOWN)
					menuItemDown();
				else if(event.key.keysym.sym == SDLK_f) {
					Screen::getInstance()->toggleFullscreen();
					updateMenuItemNames();
					this->draw();
				}
				else if(event.key.keysym.sym == SDLK_s) {
					Sounds::getInstance()->toggleEnabled();
					updateMenuItemNames();
					this->draw();
				}
				else if(event.key.keysym.sym == SDLK_m) {
					Sounds::getInstance()->toggleMusicEnabled();
					updateMenuItemNames();
					this->draw();
				}
				else if((event.key.keysym.sym == SDLK_q)||(event.key.keysym.sym == SDLK_ESCAPE))
					return 2;
				break;
		case SDL_MOUSEMOTION:
			event_x = Screen::xToClipRect(event.motion.x);
			event_y = Screen::yToClipRect(event.motion.y);
			for(uint8_t i = 0; i < menuItems.size(); ++i) {
				if (menuItems.at(i)->getXPosition() <= event_x &&
					event_x <= menuItems.at(i)->getXPosition()+menuItems.at(i)->getCurrentMenuItem()->w &&
					menuItems.at(i)->getYPosition() <= event_y &&
					event_y <= menuItems.at(i)->getYPosition()+menuItems.at(i)->getCurrentMenuItem()->h)
				{
					menuItemSelect(i);
					break;
				}
			}
			break;
		case SDL_MOUSEBUTTONDOWN:
			event_x = Screen::xToClipRect(event.motion.x);
			event_y = Screen::yToClipRect(event.motion.y);
			if (event.button.button == SDL_BUTTON_LEFT) {
				if (menuItems.at(selection)->getXPosition() <= event_x &&
					event_x <= menuItems.at(selection)->getXPosition()+menuItems.at(selection)->getCurrentMenuItem()->w &&
					menuItems.at(selection)->getYPosition() <= event_y &&
					event_y <= menuItems.at(selection)->getYPosition()+menuItems.at(selection)->getCurrentMenuItem()->h)
				{
					return handleSelection();
				}
			}
			break;
		case SDL_QUIT:
				return 2;
		}
		// Redraw, when overlapped by foreign window
		if(event.window.event == SDL_WINDOWEVENT_EXPOSED ||
		   event.window.event == SDL_WINDOWEVENT_FOCUS_GAINED) {
			Screen::getInstance()->clearOutsideClipRect();
			Screen::getInstance()->addTotalUpdateRect();
			Screen::getInstance()->Refresh();
		}
	}
	return 0;
}

void Menu::menuItemDown() {
	selection = (uint8_t) (selection - 1 + (uint8_t)menuItems.size()) % (uint8_t)menuItems.size();
	draw(false);
}

void Menu::menuItemUp() {
	selection = (uint8_t) (selection + 1) % (uint8_t)menuItems.size();
	draw(false);
}

void Menu::menuItemSelect(uint8_t selection) {
	if (this->selection != selection) {
		this->selection = selection;
		draw(false);
	}
}

MenuItem* Menu::getSelectedMenuItem() {
	return menuItems.at(selection);
}

int Menu::handleSelection() {
	return 0;
}