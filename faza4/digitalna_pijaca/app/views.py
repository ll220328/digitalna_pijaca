from django.shortcuts import render

# Create your views here.
def pocetna(request):
    return render(request, 'index.html')


def prijava(request):
    return render(request, 'prijava.html')


def registracija(request):
    return render(request, 'registracija.html')