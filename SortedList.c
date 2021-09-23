/*NAME:SHASHANK VENKAT
EMAIL: shashank18@g.ucla.edu
ID: 705303381
*/

#include "SortedList.h"
#include <stdio.h>
#include <stdlib.h>
#include <sched.h>
#include <string.h>




void SortedList_insert(SortedList_t *list, SortedListElement_t *element){
    if(list == NULL || element == NULL){
        return;
    }
    //start iterating from the second node
    //int counter = 0;
    //fprintf(stderr, "%s\n", list->next->key);
    
    if(opt_yield & INSERT_YIELD){
            sched_yield();
    }
    //fprintf(stderr, "%s\n", element->key);

    SortedListElement_t *p = list->next;
    while(p != list && p->key != NULL){
        if(strcmp(element->key, p->key) <= 0){
            break; //if it breaks here, the node needs to be inserted before the current node
        }
        //fprintf(stderr, "%d\n", counter);
        //fprintf(stderr, "%s\n", element->key);
        //exit(0);
        //counter++;
        p = p->next;
    }

    p->prev->next = element;
    element->next = p;
    element->prev = p->prev;
    p->prev = element;
    //fprintf(stderr, "done inserting\n");

}

int SortedList_delete(SortedListElement_t *element){

    //check for corruption on the next/prev pointers
    if(strcmp(element->next->prev->key, element->key) != 0 || strcmp(element->prev->next->key, element->key)!= 0) {
        //fprintf(stderr, "here\n");
        return 1;
    }

    if(opt_yield & DELETE_YIELD){
        sched_yield();
    }
    
    //rearrange pointers to account for deletion
    element->prev->next = element->next;
    element->next->prev = element->prev;
    //fprintf(stderr, "deleted\n");
    return 0;
}

SortedListElement_t *SortedList_lookup(SortedList_t *list, const char *key){
    SortedListElement_t *p = list->next;


    //int counter = 0;
    if(opt_yield & LOOKUP_YIELD)
        sched_yield();
    //iterate through list until reaching the head to find the element to look up
    while(p != list && p->key != NULL){
        //fprintf(stderr, "lookup counter, %d",counter);
        if(strcmp(p->key, key) == 0){
            //fprintf(stderr, "found\n");
            return p;
        }
        //fprintf(stderr, "pKey, %d\n", counter);
        p = p->next;
    }
    return NULL;
}


int SortedList_length(SortedList_t *list){
    int length = 0;
    
    //check for corruption
    if(list == NULL)
        return -1;
    if(list->next == NULL)
        return 0;
    SortedListElement_t *p = list->next;

    
    if(opt_yield & LOOKUP_YIELD)
        sched_yield();
    
    while(p != list && p->key != NULL){
        if(strcmp(p->next->prev->key, p->key) != 0 || strcmp(p->prev->next->key, p->key)!= 0) 
            return -1;
        length++;
        //fprintf(stderr, "%d\n", length);
        p = p->next;
    }
    return length;
}