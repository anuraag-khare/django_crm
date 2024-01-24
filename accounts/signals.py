from django.db.models.signals import post_save
from django.contrib.auth.models import User, Group
from accounts.models import Customer

from django.dispatch import receiver


@receiver(post_save, sender=User)
def create_profile(sender, instance, created, **kwargs):
    if created:
        group = Group.objects.get(name='customer')
        instance.groups.add(group)

        Customer.objects.create(user=instance, name=instance.username,)
        print('''****************
        Customer created!
        ****************''')


# post_save.connect(create_profile, sender=User)

@receiver(post_save, sender=User)
def update_profile(sender, instance, created, **kwargs):
    if created is False:
        instance.customer.email = instance.email
        name = instance.first_name + ' ' + instance.last_name
        instance.customer.name = name
        instance.customer.save()
        print('''
        ****************
        Customer Updated!
        ****************
              ''')


# post_save.connect(update_profile, sender=User)
