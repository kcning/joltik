/* testbench.c: benchmark the implementation */

#include <time.h>
#include <assert.h>

/* for profiling */
volatile unsigned int* DWT_CYCCNT  ;
volatile unsigned int* DWT_CONTROL ;
volatile unsigned int* SCB_DEMCR   ;

void
reset_timer() {
    DWT_CYCCNT   = (int*) 0xE0001004; /* address of the register */
    DWT_CONTROL  = (int*) 0xE0001000; /* address of the register */
    SCB_DEMCR    = (int*) 0xE000EDFC; /*address of the register */
    *SCB_DEMCR   = *SCB_DEMCR | 0x01000000;
    *DWT_CYCCNT  = 0; /* reset the counter */
    *DWT_CONTROL = 0;
}

void
start_timer() {
    *DWT_CONTROL = *DWT_CONTROL | 1 ; /* enable the counter */
}

void
stop_timer() {
    *DWT_CONTROL = *DWT_CONTROL | 0 ; /* disable the counter */
}

unsigned int
getCycles(){
    return *DWT_CYCCNT;
}

void
gen_rand_str(unsigned char* buffer, size_t size) {
    size_t i;
    for(i = 0; i < size; i++) {
        buffer[i] = rand();
    }
}

/* declare external assembly functions */
extern void
joltik_aead_encrypt(unsigned char *ass_data, int ass_data_len,
                    unsigned char *message, int m_len,
                    unsigned char *key,
                    unsigned char *nonce,
                    unsigned char *ciphertext, int *c_len);

extern int
joltik_aead_decrypt(unsigned char *ass_data, int ass_data_len,
                    unsigned char *message, int *m_len,
                    unsigned char *key,
                    unsigned char *nonce,
                    unsigned char *ciphertext, int c_len);

int
main(void) {

    unsigned char c[1024+8]; /* ciphertext */
    size_t c_len;

    unsigned char m[1024];
    size_t m_len = 1024;

    size_t ad_len = 8;
    unsigned char auth[8];

    unsigned char* key = "ABCDEFCGIJKLMNQU";
    unsigned char* npub = "DDDDDDDD";

    unsigned char msg[1024];
    size_t msg_len;

    int i;
    double num_cycles = 0;
    for(i = 0; i < 1000; i++) { /* test with 1000 random strings */
        gen_rand_str(m, m_len);
        memcpy(auth, m, 8); /* header */

        reset_timer();
        start_timer();

        /* rocknroll */
        joltik_aead_encrypt(auth, ad_len, m, m_len, key, npub, c, &c_len);
        joltik_aead_decrypt(auth, ad_len, msg, &msg_len, key, npub, c, c_len);
        /* done */
        
        stop_timer();
        num_cycles += (double) getCycles(); /* read number of cycles */

        /* correctness */
        assert(m_len == msg_len);
        assert(!memcmp(msg, m, m_len));
    }

    num_cycles /= 1000;
    return 0;
}
